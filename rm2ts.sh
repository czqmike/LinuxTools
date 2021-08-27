sudo apt-get install -y trash-cli
## !! Don't alias rm to trash, it may break some scripts.
echo 'alias rm="rm -I"' >> ~/.bashrc  # or .zshrc
echo 'alias ts=trash-put' >> ~/.bashrc
echo 'alias lt=trash-list' >> ~/.bashrc
## The moved files in `~/.local/share/Trash/files`
## Use `while ( echo 0 | rt ); do true; done;` or cp to restore files.
echo 'alias rt=restore-trash' >> ~/.bashrc # or trash-restore
# echo 'alias ct=trash-empty' >> ~/.bashrc

source ~/.bashrc

## Clear trash each monday 12 A.M.
crontab -l > conf && echo "0 12 * * 1 trash-empty" >> conf && crontab conf && rm -f conf
