class Game < ApplicationRecord
    before_validation(on: :create) do
      self.state = {
        0 => { 0 => nil, 1 => nil, 2 => nil },
        1 => { 0 => nil, 1 => nil, 2 => nil },
        2 => { 0 => nil, 1 => nil, 2 => nil },
      }
      self.current_symbol = [:x, :o].sample
    end
  
    after_update_commit { broadcast_update }
  
    def [](row, col)
      state[row.to_s][col.to_s]
    end
  
    # 0, 0
    def move!(row, col)
      state[row.to_s][col.to_s] = current_symbol
  
      # swap current symbol
      self.current_symbol = current_symbol == "x" ? "o" : "x"
      self.save!
    end

    def checkwinner
        row_winner = checkArrForWinner(rowToArr)
        col_winner = checkArrForWinner(colToArr)
        diagonal_winner = checkArrForWinner(diagonalsToArr)

        #Check horizontal combinations
        return row_winner unless row_winner.nil?
        #Check vertical combinations
        return col_winner unless col_winner.nil?
        #Check diagonal combinations
        return diagonal_winner unless diagonal_winner.nil?
        

        return nil
    end
    
    def checkArrForWinner(arr)
        arr.each do |n|
            if n.uniq.size <= 1 && n[0] != nil
                return n[0]
            end
        end
        return nil
    end


    def rowToArr
        new_arr = [[],[],[]]

        3.times do |r|
            3.times do |c|
                new_arr[r] << state[r.to_s][c.to_s]
            end
        end
        new_arr
    end

    def colToArr
        new_arr = [[], [], []]

        3.times do |r|
            3.times do |c|
                new_arr[r] << state[c.to_s][r.to_s]
            end
        end
        new_arr
    end

    def diagonalsToArr
        new_arr = [[], []]
        aux_index = 2

        2.times do |r|
            3.times do |c|
                if aux_index >= 0
                    new_arr[r] << state[c.to_s][aux_index.to_s]
                    aux_index -= 1
               else
                    new_arr[r] << state[c.to_s][c.to_s]
               end
            end
        end
        new_arr
    end
  end
