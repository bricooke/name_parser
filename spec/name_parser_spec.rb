$KCODE="u"
require 'lib/name_parser.rb'

describe "NameParser" do
  it "should parse a simple first and last name" do
    test [
      ["Brian Cooke", {:first_name => "Brian", :last_name => "Cooke"}]
    ]
  end
  
  it "should parse out prefixes" do
    test [
      ["Mr. Brian Cooke", {:prefix => "Mr.", :first_name => "Brian", :last_name => "Cooke"}]
    ]
  end
  
  it "should parse out suffixes" do
    test [
      ["Dinosaur Jr.", {:first_name => "Dinosaur", :suffix => "Jr."}],
      ["Mr. Brian Cooke, III", {:prefix => "Mr.", :first_name => "Brian", :last_name => "Cooke", :suffix => "III"}]
    ]
  end
  
  it "should parse out middle initials and names" do
    test [
      ["Brian Thomas Cooke", {:first_name => "Brian", :middle_name => "Thomas", :last_name => "Cooke"}],
      ["Bob W. Dilan", {:first_name => "Bob", :middle_name => "W.", :last_name => "Dilan"}]
    ]
  end
  
  # TODO: Beef this up so we can detect multiple names and handle them accordingly
  it "should handle multiple names reasonably" do
    test [
      ["Emily & Drue Jennings", {:first_name => "Emily", :last_name => "Jennings"}],
      ["Parrish & Reinish", {:first_name => "Parrish", :last_name => "Reinish"}],
      ["Elaine and Abe Kleiman", {:first_name => "Elaine", :last_name => "Kleiman"}],
      ["Mark or Joyce Barker", {:first_name => "Mark", :last_name => "Barker"}]
    ]
  end
  
  it "should ignore Current Resident" do
    test [
      ["Current Resident", {:first_name => "", :last_name => ""}],
      ["Brian Cooke or Current Resident", {:first_name => "Brian", :last_name => "Cooke"}]
    ]
  end
  
  it "should not modify the input string" do
    test = "Current Resident"
    n = NameParser.new(test)
    test.should == "Current Resident"
  end
  
  it "should handle accents in names" do
    test [
      ["Mrs. Lis\323 Bernaird", {:first_name => "Lisë", :last_name => "Bernaird"}],
      ["Lis\323 Sayer", {:first_name => "Lisë", :last_name => "Sayer"}]
    ]
  end
  
  it "should handle Mrs and Mr" do
    test [
      ["Mrs. Jane Doe", {:first_name => "Jane", :last_name => "Doe"}],
      ["Mr. John Doe", {:first_name => "John", :last_name => "Doe"}],
    ]
  end
  
  it "should handle Ms" do
    test [
      ["Ms Jane Doe", {:first_name => "Jane", :last_name => "Doe"}],
      ["Ms. Jane Doe", {:first_name => "Jane", :last_name => "Doe"}],
      ["Miss Jane Doe", {:first_name => "Jane", :last_name => "Doe"}]
    ]
  end
  
  def test(array)
    array.each do |test|
      parser = NameParser.new(test[0])
      test[1].keys.each do |key|
        parser.send(key).should == test[1][key]
      end
    end
  end
end