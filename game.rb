require 'json'

require_relative 'Controller/CharacterController'
require_relative 'Controller/HistoryController'

class Game
    def initialMenu
        puts "Digite um número para escolher uma opção:"
        puts "1 - Criar personagem"
        puts "2 - Modo história"
        puts "0 - Sair"
        opcao = gets.chomp.to_i
        return opcao
    end

    def run
        menu = 1
        while menu
            character = CharacterController.new
            history = HistoryController.new

            opcao = initialMenu()
            case opcao
            when 1
                character.createCharacter()
            when 2
                history.historyMode()
            when 0
                return
            else
                puts "Opção inválida"
            end
        end
    end
end

game = Game.new
game.run()