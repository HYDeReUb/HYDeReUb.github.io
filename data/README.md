## 驗證sha256驗證文件是否為擁有者
### 備註:此為練習用途，可能會有沒有完善的說明及缺漏的部份，敬請見諒...

### 0.請下載[sha256驗證文件.txt.gpg](https://github.com/HYDeReUb/HYDeReUb.github.io/raw/master/data/sha256%E9%A9%97%E8%AD%89%E6%96%87%E4%BB%B6.txt.gpg)
### 1.首先，需要導入個人的GPG公鑰(ID:C3661042EF14C8E3)，命令如下
`gpg --keyserver keys.openpgp.org --recv-keys C3661042EF14C8E3`
### 2.先輸入下面指令
`gpg --fingerprint C3661042EF14C8E3`
驗證公鑰指紋是否與下面的公鑰指紋吻合
```
pub   rsa3072 2022-02-25 [SC] [到期: 2024-02-25]
    這是公鑰指紋>>> 9620 F12F C25B 912C 7EBB  E364 C366 1042 EF14 C8E3 <<<這是公鑰指紋
uid           [  徹底  ] HYDeReUb <honyuan1248@gmail.com>
sub   rsa3072 2022-02-25 [E] [到期: 2024-02-25]
```
### 3.核對無誤後輸入以下指令並與上述核對公鑰指紋是否一致(注意：檔案需要放到終端機指定資料夾中)
`gpg --verify sha256驗證文件.txt.gpg`
### 4.同樣確認無誤的話，輸入以下指令解密，就會獲得sha256驗證文件.txt的文字檔(注意：檔案需要放到終端機指定資料夾中)
`gpg sha256驗證文件.txt.gpg`
### 5.點開以解密的sha256驗證文件.txt文字檔，來跟檔案輸出的sha256進行核對
#### 以下範例
1.到指定目錄時，輸入`sha256sum -b youtube下載器-python-fix.sh`後，將會獲得以下資訊(Windows請打開Powershell輸入`Get-FileHash youtube下載器-python-fix.sh`同樣也可獲得sha256資訊)
```
d8d3e4e092e5f8e39417605947a406ccd6378a6a738e29d93df844f342ffbfc8 *youtube下載器-python-fix.sh
```
2.再來比對sha256驗證文件中的youtube下載器-python-fix.sh是不是跟上面的資訊相同，若相同則沒問題，反之請不要使用

### END
