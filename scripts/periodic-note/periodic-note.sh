
PERIODIC_NOTES_FOLDER="$HOME/Documents/notes/areas/periodic/"

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
		DAY_FOLDER="daily"
		NOTE="$(date +%F%a).md"
        mkdir -p "$PERIODIC_NOTES_FOLDER/$DAY_FOLDER"
		nvim "$PERIODIC_NOTES_FOLDER/$DAY_FOLDER/$NOTE"
		;;
	week)
		WEEK_FOLDER="weekly"
		NOTE="$(date -d "next Monday - 7 days" "+%F").md"
        mkdir -p "$PERIODIC_NOTES_FOLDER/$WEEK_FOLDER"
		nvim "$PERIODIC_NOTES_FOLDER/$WEEK_FOLDER/$NOTE"
		;;
	month)
		MONTH_FOLDER="monthly"
		NOTE="$(date "+%Y-%m").md"
        mkdir -p "$PERIODIC_NOTES_FOLDER/$MONTH_FOLDER"
		nvim "$PERIODIC_NOTES_FOLDER/$MONTH_FOLDER/$NOTE"
		;;
	*)
		echo "Error: Invalid option '$1'"
		echo "$USAGE"
		exit 1
		;;
esac
