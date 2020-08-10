# 环境搭建
```
'''
Created on Jul 25, 2020

@author: liuhaoyang
https://www.pyopenssl.org/en/stable/api/crypto.html
'''

import OpenSSL
import time
from dateutil import parser
from OpenSSL.crypto import load_certificate, load_privatekey
from OpenSSL.crypto import X509Store, X509StoreContext
from OpenSSL import crypto


#错误的根证书
rootPathError = "/Users/liuhaoyang/2cWorkPlace/demo-fisco-bcos/demo1/nodes/cert/ca.crt"
rootPath =  "/Users/liuhaoyang/2cWorkPlace/generator/tmp_one_click/ca.crt"
aAGencyPath = "/Users/liuhaoyang/2cWorkPlace/generator/tmp_one_click/agencyA/agency_cert/agency.crt"
aSdkPath =  "/Users/liuhaoyang/2cWorkPlace/generator/tmp_one_click/agencyA/sdk/sdk.crt"
bAGencyPath = "/Users/liuhaoyang/2cWorkPlace/generator/tmp_one_click/agencyB/agency_cert/agency.crt"

def getCertByPath(path):
    return OpenSSL.crypto.load_certificate(OpenSSL.crypto.FILETYPE_PEM, open(path).read())


def printCert(path):
    cert = OpenSSL.crypto.load_certificate(OpenSSL.crypto.FILETYPE_PEM, open(path).read())
    certIssue = cert.get_issuer()
    print ("证书版本:            ",cert.get_version() + 1)
    print ("证书序列号:          ",hex(cert.get_serial_number()))
    print ("证书中使用的签名算法: ",cert.get_signature_algorithm().decode("UTF-8"))
    print ("颁发者:              ",certIssue.commonName)
    datetime_struct = parser.parse(cert.get_notBefore().decode("UTF-8"))
    print ("有效期从:             ",datetime_struct.strftime('%Y-%m-%d %H:%M:%S'))
    datetime_struct = parser.parse(cert.get_notAfter().decode("UTF-8"))
    print ("到:                   ",datetime_struct.strftime('%Y-%m-%d %H:%M:%S'))
    print ("证书是否已经过期:      ",cert.has_expired())
    print("公钥长度" ,cert.get_pubkey().bits())
    cert.get_issuer
    print("公钥:\n" ,OpenSSL.crypto.dump_publickey(OpenSSL.crypto.FILETYPE_PEM, cert.get_pubkey()).decode("utf-8"))
    print("主体信息:")
    print("CN : 通用名称  OU : 机构单元名称")
    print("O  : 机构名    L  : 地理位置")
    print("S  : 州/省名   C  : 国名")

    for item in certIssue.get_components():
        print(item[0].decode("utf-8"), "  ——  ",item[1].decode("utf-8"))


    print(cert.get_extension_count())



print("begin aagency....")
printCert(aAGencyPath)
print("begin asdk....")
printCert(aSdkPath)

trusted_certs = [getCertByPath(rootPath),getCertByPath(aSdkPath)]
try:
    store = crypto.X509Store()

        # Assuming the certificates are in PEM format in a trusted_certs list
    for _cert in trusted_certs:
        store.add_cert(_cert)

        # Create a certificate context using the store and the downloaded certificate
    store_ctx = crypto.X509StoreContext(store, getCertByPath(aSdkPath))

        # Verify the certificate, returns None if it can validate the certificate
    a = store_ctx.verify_certificate()
    print(a)

except Exception as e:
        print(e)
```
