"""
Usage:
  peek.py [--start-url URL]

Options:
  --start-url <URL>     Start on url URL [default: https://linkedin.com]

Environment:
N/A
"""

import docopt
import sys
from P6LIBot.P6LIBot import P6LIBot


def process(args) -> int:
    """ """
    with P6LIBot(args["--start-url"]) as li:
        li.login()
        # li.peek_at_connections()
        profile_urls = li.load_profile_urls_from_file("profile_urls.txt")
        connections = [{"profile_url": url} for url in profile_urls]
        li.view_connections(connections)

    return 0


def main() -> int:
    """ """
    arguments = {}
    arguments = docopt.docopt(__doc__, options_first=True, version="0.0.1")
    print(arguments)

    return process(arguments)


if __name__ == "__main__":
    sys.exit(main())
