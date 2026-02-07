if status is-interactive
	# Commands to run in interactive sessions can go here

	# Remove fish greeting
	set -U fish_greeting

		# User defined functions
		alias fedora='$HOME/.scripts/update.sh'
		alias neofetch='fastfetch -c neofetch'
		alias patch='$HOME/.scripts/patch.sh'
		alias update-grub='sudo grub2-mkconfig -o /boot/grub2/grub.cfg'

	# Run fastfetch configuration on shell startup (expect tty)
	fastfetch -c ~/.config/fastfetch/term.jsonc
end
