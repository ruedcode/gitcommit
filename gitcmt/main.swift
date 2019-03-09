//
//  main.swift
//  gitcmt
//
//  Created by Eugene Kalyada on 09/03/2019.
//  Copyright © 2019 EDCODE. All rights reserved.
//

import Foundation

//enum Task: String, CaseIterable {
//	case makeConfig = "make-config"
//	case checkConfig = "check-config"
//	case gitInit = "git-init"
//	case help
//	case commit
//}


class Run {
	var commands: [CommandProtocol] = []
	func perform(arguments: [String]) {
		guard arguments.count > 0, let commandName = arguments.first, let command = commands.first(where: { (row) -> Bool in
			return row.name == commandName
		}) else {
			showHelp()
			return
		}
		var args = arguments
		args.removeFirst()
		command.perform(arguments: args)
	}
	
	private func showHelp() {
		for row in commands {
			let str = String(format:"%-25s - %@\n", (row.name.color(.green) as NSString).utf8String!, row.description.color(.lightWhite))
			print(str)
		}
	}
}

let run = Run()
run.commands.append(MakeConfigCommand())
run.commands.append(CheckConfigCommand())

var arguments = CommandLine.arguments
arguments.removeFirst()
//arguments.append("make-config")
//arguments.append("test")


run.perform(arguments: arguments)
