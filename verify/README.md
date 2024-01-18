## 驗證sha256驗證文件是否正確
### 1.請下載[sha256驗證文件.txt](https://github.com/HYDeReUb/HYDeReUb.github.io/blob/verify/verify/sha256%E9%A9%97%E8%AD%89%E6%96%87%E4%BB%B6.txt?raw=true) | [sha256驗證文件.txt.sig](https://github.com/HYDeReUb/HYDeReUb.github.io/blob/verify/verify/sha256%E9%A9%97%E8%AD%89%E6%96%87%E4%BB%B6.txt.sig?raw=true) (按右鍵 > 另存連結為...)
### 2.打開sha256驗證文件.txt，來跟檔案輸出的sha256進行核對
#### 以下範例
1.到指定目錄時，輸入`sha256sum -b youtube下載器-python-fix.sh`後，將會獲得以下資訊(Windows請打開Powershell輸入`Get-FileHash youtube下載器-python-fix.sh`同樣也可獲得sha256資訊)
```
d8d3e4e092e5f8e39417605947a406ccd6378a6a738e29d93df844f342ffbfc8 *youtube下載器-python-fix.sh
```
2.再來比對sha256驗證文件中的youtube下載器-python-fix.sh是不是跟上面的資訊相同，若相同則沒問題，反之請不要使用

### <p align="center">------END------</p>
