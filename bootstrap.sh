for f in *
do
  link="$(pwd)/$f"
  as="$HOME/.$f"
  echo "Symlinking $link as $as"
done
