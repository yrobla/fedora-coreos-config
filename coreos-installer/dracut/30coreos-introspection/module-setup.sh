#!/bin/bash
# module-setup for introspection

# called by dracut
check() {
    require_binaries curl || return 1
    return 0
}

# called by dracut
depends() {
    echo network url-lib
    return 0
}

# called by dracut
install() {
    inst_multiple bzip2
    inst_multiple lsblk
    inst_multiple tee
    inst_multiple gpg
    inst_multiple curl
    inst_multiple mktemp
    inst_multiple wipefs
    inst_multiple mkfs
    inst_multiple blockdev
    inst_multiple dd
    inst_multiple awk
    inst_multiple pidof
    inst_multiple ghwc
    inst_multiple ethtool
    inst_multiple sha256sum
    inst_simple /usr/libexec/coreos-introspection
    inst_simple "$moddir/coreos-introspection.service" "${systemdsystemunitdir}/coreos-introspection.service"
    inst_hook cmdline 90 "$moddir/parse-introspection.sh"
    mkdir -p "${initdir}${systemdsystemconfdir}/initrd.target.wants"
    ln_r "${systemdsystemunitdir}/coreos-introspection.service"\
        "${systemdsystemconfdir}/initrd.target.wants/coreos-introspection.service"
}

