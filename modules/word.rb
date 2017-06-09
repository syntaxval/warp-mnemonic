# encoding: utf-8


# Word : Random funny word generator
module Word

    # Class _Factory_ for generating random funny words.
    class Factory


        # Word spawning method.
        #
        # * *Args*    :
        #   - +opts+ -> none
        # * *Returns* :
        #   - funny word
        # * *Raises* :
        #   - none
        #
        # _Example_ :
        #
        #   w = Word::Factory.new
        #   w.spawn
        #
        def spawn

            word            = ""
            lexyme_skeleton = []
            vowels          = ["a","i","e","o","u","y"]
            consonants      = ["b","c","d","e","f","g","h","i","j","k","l","m","n","p","r","s","t","w","z"]
            doublesigns     = ["sz","ch","cz","rz"]
            specialsigns    = ["ć","ń","ż","ź","ł"]
            meme_pool       = [["c","v","ds"],["v","ds","v"],["c","ds","v"],["c","ds","c"],["v","ds","c"],
                                ["ss","v","c"],["v","ss","c"],["c","ss","v"],["c","v","ss"],["v","c","ss"]]
            meme            = meme_pool[rand(meme_pool.length)]

            (2+rand(3)).times do
                lexyme_skeleton.push(["c","v"])
            end

            lexyme_skeleton.flatten!
            if rand(2) == 1
                lexyme_skeleton = mutate(lexyme_skeleton, meme)
                lexyme_skeleton.flatten!
            end

            lexyme_skeleton.each do |letter|
                case letter
                when "v"
                    word << vowels[rand(vowels.length)]
                when "c"
                    word << consonants[rand(consonants.length)]
                when "ds"
                    word << doublesigns[rand(doublesigns.length)]
                when "ss"
                    word << specialsigns[rand(specialsigns.length)]
                end
            end
            quarantine(word)
        end

        private

        # Mutate method.
        #
        # * *Args*    :
        #   - +opts+ -> lexyme_skeleton
        #   - +opts+ -> meme
        # * *Returns* :
        #   - mutated lexyme_skeleton
        # * *Raises* :
        #   - +ArgumentError+ -> if any value is nil
        #
        #
        def mutate(lexyme_skeleton, meme)
            lexyme_skeleton.insert(rand(lexyme_skeleton.length),meme)
        end


        # Quarantine method.
        #
        # * *Args*    :
        #   - +opts+ -> word
        # * *Returns* :
        #   - quarantined word (i.e. double letters are removed along with other lexical misconceptions)
        # * *Raises* :
        #   - +ArgumentError+ -> if word value is nil
        #
        #
        def quarantine(word)
            a = [/^y/,/^ó/,/^ą/,/^ę/,/^ń/,/^ć/,/ó$/,/y$/,/aa/,/ee/,/uu/,/ii/,/yy/,/oo/]
            b = ["i","u","a","e","n","c","u","i","a","e","u","i","y","o"]
            a.each_with_index do |r,i|
                word.sub!(r,b[i])
            end
            word
        end

    end

end
