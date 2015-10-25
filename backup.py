#!/usr/bin/python
"""
SYNOPSIS

    python backup.py dirs_file email password

DESCRIPTION

    Little Python script that zips files of selected filetypes
    from folders specified in <dirs_file> and sends them to
    your gmail. <dirs_file> is a plain text file containing the
    absolute paths of the folder you wish to backup, separated
    by spaces or line feeds.

    Stops adding file to archive when it reaches Gmail's size
    limit (25MB),(but write error flag to email).

    Works on my 64 bit Linux machine with Python 2.7.3

    credit for SMTP/MIME part:http://www.blog.pythonlibrary.org/

EXAMPLES

    backup.py folders_to_backup.txt john.smith@gmail.com pa$$word

                      - OR -

    backup.py folders.backup john.smith pa$$word

AUTHOR

    Alexandre Beaulne, June 2012

LICENSE

    This script is in the public domain, free from copyrights or restrictions.

"""
import smtplib
import os
import sys
import zipfile

from email import Encoders
from email.MIMEBase import MIMEBase
from email.MIMEText import MIMEText
from email.MIMEMultipart import MIMEMultipart
from email.Utils import formatdate

# type of files to archive:
TYPES = ('.py','.sh',                # Python and bash
         '.c','.cpp','.h','.hpp',    # C and C++
         '.hs','.erl',               # Haskell and erlang
         '.java','.class','.scala',  # Java and Scala
         '.bf',                      # brainfuck
         '.tex','.bib',              # LaTeX
         '.m','.mexw32','.mexglx',   # matlab
         '.jpg','.jpeg','.png',      # pics
         '.xml','.csv',              # archives
         '.html','.js',              # web and Javascript
         '.txt')                     # other

def parser(argv):
    """
    Parse the arguments to the script. Checks if
    first argument is a valid directory. Appends
    '@gmail.com' to second argument if not already
    presents.

    Returns an empty dictionary if the arguments
    are invalid.
    """
    output = dict()

    if len(argv)==3 and os.path.isfile(argv[0]):
        output["dirs_file"] = argv[0]
        output["address"] = argv[1] if '@' in argv[1] else argv[1]+"@gmail.com"
        output["password"] = argv[2]
    
    return output

def getPaths(dirs_file):
    """
    Returns an array of file paths
    from plain text file dirs_file
    """
    file_ = open(dirs_file, 'r')
    string = file_.read()
    file_.close()
    tokens = string.replace('\n',' ').split()
    return [X for X in tokens if os.path.isdir(X)]

def getFiles(paths, types):
    """
    Function returning all
    files with extensions in types
    and in subdirectories paths
    """
    output = list()

    for path in paths:
        for root, dirs, files in os.walk(path):
            for file_ in files:
                if file_.lower().endswith(types):
                    temp = os.path.join(root,file_)
                    temp = temp if os.path.exists(temp) else os.readlink(temp)
                    output.append(temp)

    return output

def zipFiles(archivePath, paths):
    """
    Zips the files given in paths
    into archive archivePath.

    Excludes files that would
    make the archive bigger than
    Gmail size limit.

    Return a string with the
    status of every files
    (Included or Excluded)
    """
    archive = zipfile.ZipFile(archivePath, 'w')
    archsize = os.path.getsize(archivePath)/1000000

    text = ''

    for path in paths:
        filesize = os.path.getsize(path)/1000000
        if archsize+filesize>24:
            text += 'Excluded '+path+': Zip file already too big for Gmail size limits\n'
        else:
            dest = os.path.join('/backup/', os.path.basename(path))
            archive.write(path, dest, zipfile.ZIP_DEFLATED)
            archsize = os.path.getsize(archivePath)/1000000
            text += 'Included '+path+'\n'

    archive.close()
    return text
 
def sendMail(address, password, recipient, body, subject="New Mail", attachment=""):
    """ Sends an email """

    msg = MIMEMultipart()
    msg['From'] = address
    msg['To'] = recipient
    msg['Subject'] = subject
    msg['Date'] = formatdate(localtime=True)
    msg.attach(MIMEText(body))

    # attach the file
    part = MIMEBase('application', 'octet-stream')
    part.set_payload(open(attachment,'rb').read())
    Encoders.encode_base64(part)
    part.add_header("Content-Disposition", "attachment; filename=%s" % os.path.basename(attachment))
    msg.attach(part)

    server = smtplib.SMTP('smtp.gmail.com:587')  
    server.starttls()  
    server.login(address, password)  
    server.sendmail(address, recipient, msg.as_string())  
    server.quit()

if __name__ == "__main__":

    credentials = parser(sys.argv[1:])

    if not credentials:
        print __doc__
    else:
        print "Searching directories and subdirectories for files..."
        folders = getPaths(credentials["dirs_file"])
        paths = getFiles(folders, TYPES)
        archivePath = os.path.join(os.getcwd(), "backup.zip")
        print 'Zipping the files...'
        text = zipFiles(archivePath, paths)
        print 'Sending the email...'
        sendMail(credentials["address"],
                 credentials["password"],
                 credentials["address"],
                 text,
                 subject="BACKUP",
                 attachment=archivePath)
        # Delete archive on local computer
        print 'Cleaning up...'
        os.remove(archivePath)

        print "Backup completed - email sent to " + credentials["address"]
 
