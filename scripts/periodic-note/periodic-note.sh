

NOTES_FOLDER="$HOME/Documents/notes"
PERIODIC_NOTES_FOLDER="areas/periodic/"
DAY_FOLDER="daily"
WEEK_FOLDER="weekly"
MONTH_FOLDER="monthly"

_open_note() {
    local DIRECTORY="$1"
    local NOTE="$2"
    mkdir -p "$NOTES_FOLDER/$PERIODIC_NOTES_FOLDER/$DIRECTORY"
    pushd "$NOTES_FOLDER" > /dev/null
    nvim "$PERIODIC_NOTES_FOLDER/$DIRECTORY/$NOTE"
    popd > /dev/null
}


USAGE="Usage: $0 {day|week|month|-h|--help}"
if [ -z "${1:-}" ]; then
	echo "$USAGE"
	exit 1
fi

case "$1" in
	-h|--help)
		echo "$USAGE"
		echo ""
		echo "Options:"
		echo "  day      Open neovim on today's daily note."
		echo "  week     Open neovim on this week's weekly note."
		echo "  month    Open neovimon this month's monthly note."
		echo "  -h|help  Display this help message."
		exit 0
		;;
  
	day)
		NOTE="$(date +%F%a).md"
        _open_note "$DAY_FOLDER" "$NOTE"
		;;
	week)
		NOTE="$(date -d "next Monday - 7 days" "+%F").md"
        _open_note "$WEEK_FOLDER" "$NOTE"
		;;
	month)
		MONTH_FOLDER="monthly"
		NOTE="$(date "+%Y-%m").md"
        _open_note "$MONTH_FOLDER" "$NOTE"
		;;
	*)
		echo "Error: Invalid option '$1'"
		echo "$USAGE"
		exit 1
		;;
esac
