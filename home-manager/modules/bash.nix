# Dotfiles and configurations for my machines.
# Copyright (C) 2024 Alex Bechanko
# 
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

{username, hostname, ...}: {
  programs.bash = {
    enable = true;

    initExtra = ''
      export PS1="\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ "
    '';

    shellAliases = {
      home-manager = "home-manager --flake /home/alex/Projects/github.com/alex-bechanko/dotfiles#${username}@${hostname}";
      diff = "diff --color -u";
      grep = "grep -Hn";
      dotfiles = "cd /home/alex/Projects/github.com/alex-bechanko/dotfiles";
    };
  };

}
