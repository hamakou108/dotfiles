" 拡張子がtexのファイルを編集するときだけ折り返しを有効化する．
if expand("%:t") =~ ".*\.tex"
  :set wrap
endif
" 拡張子がtxtのファイルを編集するときだけ折り返しを有効化する．
if expand("%:t") =~ ".*\.txt"
  :set wrap
endif
" 拡張子がhtmlのファイルを編集するときだけ折り返しを有効化する．
if expand("%:t") =~ ".*\.html"
  :set wrap
endif
" 拡張子がmdのファイルを編集するときだけ折り返しを有効化する．
if expand("%:t") =~ ".*\.md"
  :set wrap
endif
