#!/run/current-system/sw/bin/bash

NIXOS=/etc/nixos
MYCFG=/home/dlkrejsa/nixos-cfg

cd $MYCFG
for f in *.nix ; do
    diff -q $NIXOS/$f $f > /dev/null 2>&1 || {
        stat=$? ;
        if (($stat == 1)) ; then
            echo "sudo cp $f $NIXOS/$f"
            sudo cp $f $NIXOS/$f
        else
            echo "Problem in 'diff $NIXOS/$f $f'" >&2
        fi ;
    }
done

