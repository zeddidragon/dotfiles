# dotfiles bootstrapper, written exactly as advanced as I currently need it
# if you had something already that matches the dotfile name,
# then tough, it's getting overwritten
require 'fileutils'

files = Dir.glob('*') - [__FILE__, 'vimfiles']

files.each do |file|
  to = File.join Dir.pwd, file
  as = File.join Dir.home, ".#{file}"
  FileUtils.ln_s to, as, force: true, verbose: true
end

FileUtils.ln_s File.join(Dir.pwd, 'vimfiles'), File.join(Dir.home, '.vim'), force: true, verbose: true
