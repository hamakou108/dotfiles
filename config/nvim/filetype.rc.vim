" LaTeX
if expand("%:t") =~ ".*\.tex"
  :set wrap
endif

" Normal text
if expand("%:t") =~ ".*\.txt"
  :set wrap
endif

" HTML
if expand("%:t") =~ ".*\.html"
  :set wrap
endif

" Markdown
if expand("%:t") =~ ".*\.md"
  :set wrap
endif
