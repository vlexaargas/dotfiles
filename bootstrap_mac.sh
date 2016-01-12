#
# Script to boostrap a new personal computer for Alex Vargas from Scratch
#
# Setup:
#
# - Before running this, the xcode cli tools should be installed. Alternatively,
# the full xcode app can be installed. I have just installed xcode because I will
# be doing ios development anyway. 
#
# Need to be installed externally:
#
# - VirtualBox
# - Vagrant
#

#
# Install Homebrew
#

which -s brew
if [[ $? != 0 ]] ; then
	echo "Installing Homebrew..."
	ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
	echo "Updating Homebrew..."
	brew update; brew cleanup
fi

#
# Install zsh
#
if [ -z $(brew list -1 | grep zsh) ] ; then
  echo "Installing zsh..."

  # install
  brew install zsh

  # set as default shell
  chsh -s /bin/zsh
fi

#
# Install antigen - like bundle for zsh
#
if [ ! -f ~/.antigen.zsh ]; then
  echo "Installing antigen..."
  curl -L https://raw.githubusercontent.com/zsh-users/antigen/master/antigen.zsh > ~/.antigen.zsh
fi

#
# Install Tmux
#
if [ -z $(brew list -1 | grep tmux) ] ; then
  echo "Installing tmux..."
  brew install tmux
else
  echo "Updating tmux..."
  brew upgrade tmux
fi

#
# Install MacVim - Use as new default version of vim
#
which -s mvim
if [[ $? != 0 ]] ; then
	echo "Installing MacVim..."
  brew install macvim --with-override-system-vim
else
	echo "Updating MacVim..."
  brew upgrade macvim
fi

#
# Install rbenv
#
# I have mostly used rvm in the past - trying rbenv out here.
#

which -s rbenv
if [[ $? != 0 ]] ; then
	echo "Installing rbenv..."
	brew install rbenv ruby-build
else
	echo "Updating rbenv..."
	brew upgrade rbenv ruby-build
fi

#
# Install latest version of ruby
#

# Find latest version of ruby available to install
LATEST_RUBY_VERSION=$(rbenv install -l | sed -n '/^[[:space:]]*[0-9]\{1,\}\.[0-9]\{1,\}\.[0-9]\{1,\}[[:space:]]*$/ h;${g;p;}')

if [ -z "$(rbenv versions | grep $LATEST_RUBY_VERSION)" ] ; then
  echo "Installing latest version of ruby..."
  rbenv install -s $LATEST_RUBY_VERSION
  rbenv global $LATEST_RUBY_VERSION
  rbenv rehash
fi

#
# Install rails
#

if [ -z "$(gem list | grep rails)" ] ; then
	echo "Installing rails..."
  gem install rails
fi

#
# Install Ag - fastest alternative to grep
#

which -s ag
if [[ $? != 0 ]] ; then
	echo "Installing ag..."
	brew install the_silver_searcher
else
	echo "Updating ag..."
	brew upgrade the_silver_searcher
fi
