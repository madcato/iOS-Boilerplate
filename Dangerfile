# Sometimes it's a README fix, or something like that - which isn't relevant for
# including in a project's CHANGELOG for example
declared_trivial = gitlab.pr_title.include? "#trivial"

# Make it more obvious that a PR is a work in progress and shouldn't be merged yet
warn "MR is classed as Work in Progress" if gitlab.mr_title.include? "[WIP]"

# Warn when there is a big PR
warn("Big PR") if git.lines_of_code > 500

warn "This MR does not have any assignees yet." unless gitlab.mr_json["assignee"]

# Don't let testing shortcuts get into master by accident
fail("fdescribe left in tests") if `grep -r fdescribe specs/ `.length > 1
fail("fit left in tests") if `grep -r fit specs/ `.length > 1

message("This is a pru.")

swiftlint.lint_files

# xcodebuild
xcodebuild.json_file = "./fastlane/reports/xcpretty-json-formatter-results.json"
xcodebuild.parse_warnings # returns number of warnings
xcodebuild.parse_errors # returns number of errors
xcodebuild.parse_tests # returns number of test failures
xcodebuild.perfect_build # returns a bool indicating if the build was perfect

# xcov
xcov.report(
   scheme: 'iOS-Boilerplate',
   project: 'iOS-Boilerplate.xcodeproj',
   minimum_coverage_percentage: 25
)