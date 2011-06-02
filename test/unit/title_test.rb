require 'test_helper'

class TitleTest < ActiveSupport::TestCase
  test "should show available titles" do
    titles = Title.find_all_available
    assert_equal 2, titles.size
    assert_equal titles(:one), titles.first
  end

  test "should change status to selecionado" do
    assert_equal "Digitado", titles(:one).status
    titles(:one).select!
    assert_equal "Selecionado", titles(:one).status
  end

  test "should convert value" do
    title = Title.new
    title.value = 10.3
    assert_equal "10,30",title.value.real.to_s
  end

  test "should create 'digitão cobrança'" do
    assert_equal(1, Title.calcula_digitao("501","6703255","3020"))
  end

  test "should create 'digitão cobrança' 2" do
    assert_equal(0, Title.calcula_digitao("0527","5739694","9500019"))
  end

  test "should create 'digitão cobrança' 3" do
    assert_equal(7, Title.calcula_digitao("0527","5739694","9500061"))
  end

  test "should create 'digitão cobrança' 4" do
    assert_equal(2, Title.calcula_digitao("0527","5739694","9500090"))
  end

  test "should create 'digitão cobrança' 5" do
    assert_equal(4, Title.calcula_digitao("0527","5739694","009500007"))
  end

  test "should create 'digitão cobrança' 6" do
    assert_equal(1, Title.calcula_digitao("0527","5739694","0000009500257"))
  end

  test "should create 'barra digitavel'" do
    line = Title.create_linha_digitavel("356","501","6703255","3020",35,"1",Date.strptime("02/10/2001","%d/%m/%Y"),"9")
    assert_equal "35690.50168", line[0,11]
    assert_equal "70325.510009", line[12,12]
    assert_equal "00000.030205", line[25,12]
    assert_equal "9", line[38,1]
    assert_equal "14560000003500", line[40,14]
  end

  test "should create 'barra digitavel' 2" do
    line = Title.create_linha_digitavel("356","0527","5739694","9500019",50,"0",Date.strptime("10/06/2009","%d/%m/%Y"),"7")
    assert_equal "35690.52750", line[0,11]
    assert_equal "73969.400008", line[12,12]
    assert_equal "00095.000196", line[25,12]
    assert_equal "7", line[38,1]
    assert_equal "42640000005000", line[40,14]
  end

  test "should create 'barra digitavel' 3" do
    line = Title.create_linha_digitavel("356","0527","5739694","0000009500009",450,"2",Date.strptime("27/05/2009","%d/%m/%Y"),"5")
    assert_equal "35690.52750", line[0,11]
    assert_equal "73969.420006", line[12,12]
    assert_equal "00095.000097", line[25,12]
    assert_equal "5", line[38,1]
    assert_equal "42500000045000", line[40,14]
  end

  test "should create 'barra digitavel' 4" do
    line = Title.create_linha_digitavel("356","0527","5739694","0000009500007",50,"4",Date.strptime("22/05/2009","%d/%m/%Y"),"4")
    assert_equal "35690.52750", line[0,11]
    assert_equal "73969.440004", line[12,12]
    assert_equal "00095.000071", line[25,12]
    assert_equal "4", line[38,1]
    assert_equal "42450000005000", line[40,14]
  end

  test "should create 'digitão cod barra'" do
    assert_equal(9, Title.calcula_digitao_cod_barra("356", Date.strptime("02/10/2001","%d/%m/%Y"),35,"501","6703255","1","000003020"))
  end

  test "should create 'digitão cod barra' 2" do
    assert_equal(5, Title.calcula_digitao_cod_barra("356", Date.strptime("27/05/2009","%d/%m/%Y"),450,"0527","5739694","2","0000009500009"))
  end

  test "should create 'digitão cod barra' 3" do
    assert_equal(4, Title.calcula_digitao_cod_barra("356", Date.strptime("22/05/2009","%d/%m/%Y"),50,"0527","5739694","4","0000009500007"))
  end

  test "should create 'digitão cod barra' 4" do
    assert_equal(1, Title.calcula_digitao_cod_barra("356", Date.strptime("11/04/2010","%d/%m/%Y"),75,"0527","5739694","1","0000009500257"))
  end

end
