"-------------------------------------------------------------------------------
"  Description: Numbered Central Backup - tested on Linux and Windows, Mac
"    Copyright: Copyright (C) 2011 Ondrej Brablc, (C) 2006 Martin Krischik
"   Maintainer: Ondrej Brablc
"-------------------------------------------------------------------------------
" Customize:
"  g:ncbackup_directory   name of backup directory central to edited file
"                       by default ~/.vim-backups
"  g:ncbackup_purge       count of backups to hold - purge older once.
"                       0 switched the feature of
"-------------------------------------------------------------------------------

if exists("s:ncbackup_loaded") || version < 700
    finish
endif

let s:ncbackup_loaded = 10
setlocal cpoptions-=C

if ! exists("g:ncbackup_purge")
   let g:ncbackup_purge=10
endif

if ! exists("g:ncbackup_directory")
   let g:ncbackup_directory="~/.vim/.ncbackup"
endif

set writebackup
set backup
set backupext=;1

execute "set directory^=" . g:ncbackup_directory

" Subsection: s:Make_Backup_Dir 
"
function s:Make_Backup_Dir (Path)
   if strlen (finddir (a:Path)) == 0
      call mkdir (a:Path, "p", 0770)
   endif
endfunction Make_Backup_Dir

" Subsection: s:Get_Version 
"
function s:Get_Version (Filename)
   return eval ( strpart ( a:Filename, strridx (a:Filename, ";") + 1))
endfunction s:Get_Version

" Subsection: s:Version_Compare 
"
function s:Version_Compare (Left, Right)
   let l:Left_Ver = s:Get_Version (a:Left)
   let l:Right_Ver = s:Get_Version (a:Right)
   return l:Left_Ver == l:Right_Ver ? 0 : ( l:Left_Ver > l:Right_Ver ? 1 : -1 )
endfunction s:Version_Compare

" Subsection: s:Do_Purge 
"
function s:Set_Backup (Doc_Path, Doc_Name)
   let l:Backup_Path = expand(g:ncbackup_directory) . '/' . substitute( a:Doc_Path, '\(:\\\|\\\)', '/', 'g')
   call s:Make_Backup_Dir (l:Backup_Path)
   execute "set backupdir^=" . fnameescape(l:Backup_Path)
   let l:Existing_Backups = sort ( split ( glob (l:Backup_Path . '/' . a:Doc_Name . ';*'), "\n"), "s:Version_Compare")
   if empty (l:Existing_Backups)
      set backupext=;1
   else
      let &backupext=';' . string (s:Get_Version (l:Existing_Backups[-1]) + 1)
      if g:ncbackup_purge > 0 && len (l:Existing_Backups) > g:ncbackup_purge
          for l:Item in l:Existing_Backups[0 :  len (l:Existing_Backups) - g:ncbackup_purge]
              call delete (l:Item)
          endfor
      endif
   endif
endfunction Set_Backup

call s:Make_Backup_Dir (expand (g:ncbackup_directory))
autocmd BufWritePre * :call s:Set_Backup ( expand ('<afile>:p:h'), expand ('<afile>:p:t'))

