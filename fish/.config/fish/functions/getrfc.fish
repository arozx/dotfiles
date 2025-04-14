function getrfc
    set -l rfc_id $argv[1]

    if test -z "$rfc_id"
        echo "Usage: getrfc <RFC number>"
        return 1
    end

    set -l rfc_dir "$HOME/rfc"
    set -l txt_file "$rfc_dir/rfc$rfc_id.txt"
    set -l md_file "$rfc_dir/rfc$rfc_id.md"

    mkdir -p $rfc_dir

    echo "📥 Downloading RFC $rfc_id..."
    curl -s "https://www.rfc-editor.org/rfc/rfc$rfc_id.txt" -o $txt_file

    if test $status -ne 0
        echo "❌ Failed to download RFC $rfc_id"
        return 1
    end

    cd $rfc_dir

    mv rfc$rfc_id.txt rfc$rfc_id.md

    echo "📖 Opening with nvim..."
    nvim rfc$rfc_id.md
end

