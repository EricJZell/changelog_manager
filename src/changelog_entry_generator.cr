require "./cli_tool"
class ChangelogEntryGenerator
	include CliTool


	def run()
		#OPTIONAL test if needs changelog

		cd = get_changelog_db(get_called_from())

		change_type = get_change_type()

		ticket      = Readline.readline("Ticket ID? (optional): ")
		url         = Readline.readline("Ticket URL? (optional): ")
		description = ask_for_non_optional_input("Describe your change: ")
		# TODO support tags

		changelog_entry = ChangelogEntry.new(change_type, 
											description,
											ticket,
											url,
											[] of String)
		# puts changelog_entry.to_json
		new_entry_location = changelog_entry.export(cd)
		success = GitIntegration.add_file(new_entry_location, changelog_entry)
		if success 
			puts "Added #{new_entry_location} to git"
		else
			#can't happen
			puts "Problems were encountered"
			exit 2
		end
		exit 0
	end





	# def needs_changelog?() : Bool
	# 	ask_yes_no("Need Changelog Entry?")
	# 	if ! need_changelog 
	# 		puts "OK"
	# 		exit 0
	# 	end
	# end

end
