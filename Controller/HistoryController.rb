
# eu escolho a opção de historia
# sistema mostra personagens e pede para eu escolher um
# eu escolho um personagem

# repete ate que todos os inimigos tenham sido derrotados ou o jogador morra
#     o sistema me joga contra o n-esimo personagem
#     mostra os atributos do personagem que escolhi
#     mostra os inimigos com quem vou lutar
#     repete até que a vida de algum chegue a zero - dizendo quem venceu o jogo
#         o sistema lista os ataques disponíveis (é a sua vez)
#         eu escolho um ataque
#         sistema diz qeu o personagem atacou com tal ataque
#         o sistema mostra quanto dano o ataque fez no inimigo (tambem dinimui a vida do inimigo)
#         sistema diz que agora eh a vez do inimigo
#         vai sempre usar o mesmo ataque
#         sistema vai dizer quanto dano o ataque causou, e diminui a vida do jogador
#     -----------
#     se p1 não morreu, fala que venceu, reseta a vida
# ----------
# se morreu - fala que morreu
# se terminou a história, estoura um champanhe

require_relative '../Services/CharacterService'

class HistoryController
    def initialize
        @characterService = CharacterService.new
    end

    def historyMode()
        characters = @characterService.getAll('enemy')
        personagemEscolhido = chooseCharacter(characters)
        nome = characters[personagemEscolhido.to_i - 1].nome
        player1 = @characterService.getOne(nome)

        characters.each_with_index do |enemy, index|
            listAttributes(player1)
            puts "VERSUS"
            listAttributes(enemy)
            puts "pressione enter para continuar"
            gets
            perdeu = false
            combate = true
            while combate
                if player1.atributos['vida'] > 0
                    puts
                    puts "Player1 escolha seu ataque:"
                    listaAtaques(player1)
                    ataqueEscolhido = gets.chomp

                    ataque = player1.ataques[ataqueEscolhido.to_i - 1]
                    puts
                    puts "[COMBATE] Voce atacou com #{ataque['nome']} causando #{ataque['dano']} de dano";
                    enemy.atributos['vida'] -= ataque['dano']
                    puts "[COMBATE] #{enemy.nome} está com #{enemy.atributos['vida']} de vida"
                end

                if enemy.atributos['vida'] > 0
                    ataqueEscolhidoInimigo = 0
                    ataqueInimigo = enemy.ataques[ataqueEscolhidoInimigo]
                    puts
                    puts "[COMBATE] Inimigo atacou com #{ataqueInimigo['nome']} causando #{ataqueInimigo['dano']} de dano";
                    player1.atributos['vida'] -= ataqueInimigo['dano']
                    puts "[COMBATE] você está com #{player1.atributos['vida']} de vida"
                end

                if player1.atributos['vida'] <= 0
                    puts
                    puts 'voce morreu'
                    puts "pressione enter para continuar"
                    gets
                    combate = false
                    perdeu = true
                elsif enemy.atributos['vida'] <= 0
                    puts
                    puts 'voce venceu'
                    puts "pressione enter para continuar"
                    gets
                    player1.atributos['vida'] = player1.atributos['vidaMaxima']
                    combate = false
                end
            end
            if perdeu == true
                break
            end
        end
    end

    def chooseCharacter(characters)
        pedir = true
        while pedir
            # exibe
            puts "Pressione um número para escolher um personagem:"
            characters.each_with_index do |character, index|
                puts "#{index += 1} - #{character.nome}"
            end
            # pede
            personagemEscolhido = gets.chomp
            # valida
            if (personagemEscolhido.to_i <= 0 || personagemEscolhido.to_i > characters.length)
                puts "Opção inválida!"
            else
                pedir = false
            end
        end
        return personagemEscolhido
    end

    def  listAttributes(character)
        puts
        puts "Dados do personagem:"
        puts "Nome: #{character.nome}"
        puts "Classe: #{character.classe}"
        puts "Atributos:"
        puts "  Vida máxima: #{character.atributos["vidaMaxima"]}"
        puts "  Vida: #{character.atributos["vida"]}"
        puts "Ataques:"
        listaAtaques(character)
        puts
    end

    def listaAtaques character
        ataques = character.ataques
        ataques.each_with_index do |ataque, index|
            puts " #{index+1} - Nome: #{ataque["nome"]}, Dano: #{ataque["dano"]}"
        end
    end
end
