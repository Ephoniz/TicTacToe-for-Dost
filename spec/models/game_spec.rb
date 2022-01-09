require 'rails_helper'

RSpec.describe Game, type: :model do
    subject { Game.create }

    it "creates an 'empty' json on game start" do
        empty_json = {"0"=>{"0"=>nil, "1"=>nil, "2"=>nil},
                      "1"=>{"0"=>nil, "1"=>nil, "2"=>nil}, 
                      "2"=>{"0"=>nil, "1"=>nil, "2"=>nil}}
        expect(subject.state).to eql(empty_json)
    end

    it "asigns random symbol at the start of the game" do
        expect(['x', 'o']).to include(subject.current_symbol)
    end

    describe '#checkwinner' do 
        it "will win when row completed" do
            subject.state['0']['0'] = 'x'
            subject.state['0']['1'] = 'x'
            subject.state['0']['2'] = 'x'
            expect(subject.checkwinner).to eql('x')
        end

        it "will win when column completed"  do
            subject.state['0']['0'] = 'x'
            subject.state['1']['0'] = 'x'
            subject.state['2']['0'] = 'x'
            expect(subject.checkwinner).to eql('x')
        end

        it "will win when diagonal completed" do
            subject.state['0']['2'] = 'x'
            subject.state['1']['1'] = 'x'
            subject.state['2']['0'] = 'x'
            expect(subject.checkwinner).to eql('x')
        end
    end

    describe '#move!' do
        it "will change symbol when moving ( x to o when previous movement was x and the other way around)" do
            previous_symbol = subject.current_symbol
            subject.move!(0, 1)
            expect(subject.current_symbol).to_not eql(previous_symbol)
        end

        it "will correctly make a 'move' for the symbol that made it" do
            previous_symbol = subject.current_symbol
            subject.move!(0, 1)
            expect(subject.state['0']['1']).to eql(previous_symbol)
        end
    end

    describe '#rowToArr' do
        it "will transform the json rows to an array of nested arrays" do
            expect(subject.rowToArr).to be_an_instance_of(Array)
        end

        it "will give the proper row" do
            subject.state['0']['1'] = 'x'
            subject.state['1']['0'] = 'o'
            subject.state['2']['2'] = 'x'
            test_array = [[nil, 'x', nil], ['o', nil, nil], [nil, nil, 'x']]
            expect(subject.rowToArr).to eql(test_array)
        end
    end

    describe '#colToArr' do
        it "will transform the json rows to an array of nested arrays" do
            expect(subject.colToArr).to be_an_instance_of(Array)
        end

        it "will give the proper columns" do
            subject.state['0']['1'] = 'x'
            subject.state['1']['0'] = 'o'
            subject.state['2']['2'] = 'x'
            test_array = [[nil, 'o', nil], ['x', nil, nil], [nil, nil, 'x']]
            expect(subject.colToArr).to eql(test_array)
        end
    end

    describe '#diagonalsToArr' do
        it "will transform the json rows to an array of nested arrays" do
            expect(subject.diagonalsToArr).to be_an_instance_of(Array)
        end

        it "will give the proper diagonals" do
            subject.state['0']['1'] = 'x'
            subject.state['1']['0'] = 'o'
            subject.state['2']['2'] = 'x'
            test_array = [[nil, nil, nil], [nil, nil, 'x']]
            expect(subject.diagonalsToArr).to eql(test_array)
        end
    end

    describe '#checkArrForWinner' do
        it "will return 'nil' when no winning combination found" do
            
        end

        it "will return the winning symbol found when there is a winning combination" do
            subject.state['0']['0'] = 'x'
            subject.state['0']['1'] = 'x'
            subject.state['0']['2'] = 'x'

            expect(subject.checkArrForWinner(subject.rowToArr)).to eql('x')
        end
    end
  
end
