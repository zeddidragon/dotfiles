# dotfiles bootstrapper, written exactly as advanced as I currently need it
# if you had something already that matches the dotfile name,
# then tough, it's getting deleted
require 'fileutils'

def symlink to, as
  to = File.join Dir.pwd, to
  as = File.join Dir.home, as
  FileUtils.remove_entry as if File.exists? as
  FileUtils.ln_s to, as, force: true, verbose: true
end

files = Dir.glob('*') - [__FILE__, 'keymap.c', 'vimfiles', 'z', 'submodules']

files.each{|file| symlink file, ".#{file}"}
symlink 'vimfiles', '.vim'
symlink 'z/z.sh', 'z.sh'
symlink 'submodules/purer/pure.zsh', '.zfunctions/prompt_pure_setup'
symlink 'submodules/purer/async.zsh', '.zfunctions/async'
