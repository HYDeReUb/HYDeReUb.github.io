## 驗證sha256驗證文件是否為擁有者
### 0.請下載[sha256驗證文件.txt](https://github.com/HYDeReUb/HYDeReUb.github.io/blob/verify/verify/sha256%E9%A9%97%E8%AD%89%E6%96%87%E4%BB%B6.txt?raw=true) | [sha256驗證文件.txt.sig](https://github.com/HYDeReUb/HYDeReUb.github.io/blob/verify/verify/sha256%E9%A9%97%E8%AD%89%E6%96%87%E4%BB%B6.txt.sig?raw=true) (按右鍵 > 另存連結為...)
### 1.首先，需要導入個人的GPG公鑰(ID:`C3661042EF14C8E3` Keyserver:`hkp://keys.openpgp.org`)，命令如下
`gpg --keyserver keys.openpgp.org --recv-keys C3661042EF14C8E3`
### 2.先輸入下面指令
`gpg --fingerprint C3661042EF14C8E3`<br>
#### 驗證公鑰指紋是否與下面的公鑰指紋吻合
```
pub   rsa3072 2022-02-25 [SC] [到期: 2024-02-25]
      9620 F12F C25B 912C 7EBB  E364 C366 1042 EF14 C8E3
uid           [  徹底  ] HYDeReUb (GitHub key) <honyuan1248@gmail.com>
uid           [  徹底  ] HYDeReUb <honyuan1248@gmail.com>
sub   rsa3072 2022-02-25 [E] [到期: 2024-02-25]
```
### 3.核對無誤後輸入以下指令並確認簽章是否完好(注意：檔案需要放到終端機指定資料夾中)
`gpg --verify sha256驗證文件.txt.sig sha256驗證文件.txt`
### 4.同樣確認無誤的話即可打開sha256驗證文件.txt，來跟檔案輸出的sha256進行核對
#### 以下範例
1.到指定目錄時，輸入`sha256sum -b youtube下載器-python-fix.sh`後，將會獲得以下資訊(Windows請打開Powershell輸入`Get-FileHash youtube下載器-python-fix.sh`同樣也可獲得sha256資訊)
```
d8d3e4e092e5f8e39417605947a406ccd6378a6a738e29d93df844f342ffbfc8 *youtube下載器-python-fix.sh
```
2.再來比對sha256驗證文件中的youtube下載器-python-fix.sh是不是跟上面的資訊相同，若相同則沒問題，反之請不要使用

### <p align="center">------END------</p>
