#!/usr/bin/env sh

mem () {
    i="0"
        while read LINE; do
        i="$((i+1))"
        MEMINFO="$MEMINFO$LINE
"
        [ "$i" -eq 5 ] && break
    done < /proc/meminfo
        set -- $MEMINFO
    printf "$((($2-$5-${11}-${14})/1024)) / $(($2/1024)) MB"
    }

    kernelver () {
        uname -r
}

clock () {
    TZ='UTC' date "+%H:%M:%S %e %b %Y"
    }

    cpu () {
        read CPU < /proc/stat
    set -- $CPU
        printf "$((($2+$4)*100/($2+$4+$5))) %%"
}

rootspace () {
    df -h | while read LINE; do
            if [ "${LINE%%nvme0n1p2*}" = "/dev/" ]; then
                set -- $LINE
            printf "$4 free in $6"
                break
        fi
    done
    }

    while true; do
        printf "%s" "$(cpu) | $(mem) | $(rootspace) | $(kernelver) | $(clock)"
    sleep 1
    done
