
mkdir -p ~/.dotfiles/arch-packages/arch-packages/inventory

# All explicitly installed packages (repo + AUR)
pacman -Qqe > ~/.dotfiles/arch-packages/arch-packages/inventory/explicit-all.txt

# Explicit native (official repos)
pacman -Qen > ~/.dotfiles/arch-packages/arch-packages/inventory/explicit-repo.txt

# Explicit foreign (AUR/local) – stuff managed by yay/paru
pacman -Qem > ~/.dotfiles/arch-packages/arch-packages/inventory/explicit-aur.txt

# Orphaned dependencies (safe first candidates to remove, but still review)
pacman -Qdtq > ~/.dotfiles/arch-packages/arch-packages/inventory/orphans.txt 2>/dev/null || echo "no orphans"

# Everything installed (for completeness)
pacman -Qq > ~/.dotfiles/arch-packages/arch-packages/inventory/all-installed.txt

# Explicit packages with 1-line descriptions (repo + AUR)
while read -r pkg; do
  desc=$(pacman -Qi "$pkg" 2>/dev/null \
           | sed -n 's/^Description\s*:\s*//p' \
           | head -n 1)
  printf '%-30s  %s\n' "$pkg" "$desc"
done < <(pacman -Qqe) \
  > ~/.dotfiles/arch-packages/arch-packages/inventory/explicit-with-descriptions.txt
