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

{...}: {
  programs.alacritty = {
    enable = true;
    settings = {
      window.startup_mode = "Maximized";
      window.decorations = "None";
      font.size = 10.0;
      font.bold.family = "IosevkaTerm Nerd Font";
      font.bold.style = "Bold";
      font.normal.family = "IosevkaTerm Nerd Font";
      font.normal.style = "Regular";
    };
  };
}
