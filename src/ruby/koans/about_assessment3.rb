require File.expand_path(File.dirname(__FILE__) + '/neo')
 
class Counter
  
  def ordered_places_by_year(year)
    events = File.read("events_by_year2.txt")
    # TODO
  end

  def count_year_by_person(person, degree_stop=nil)
    degrees = File.read("degrees_by_person2.txt")
    degree_order = ['ensino-fundamental', 'ensino-medio', 'graduacao', 'aperfeicoamento', 'especializacao', 'mestrado', 'doutorado', 'pos-doutorado']
    # TODO
  end
  
end
 
class AboutMixProject < Neo::Koan

  def test_process_count_place_by_year
    place = Counter.new
    assert_equal(["joao pessoa", "recife", "rio de janeiro", "sao paulo"],place.ordered_places_by_year(2014))
    assert_equal(["recife", "joao pessoa", "rio de janeiro", "sao paulo"],place.ordered_places_by_year(2013))
    assert_equal(["rio de janeiro", "sao paulo", "joao pessoa"],place.ordered_places_by_year(2011))
    assert_equal(["sao paulo", "joao pessoa", "recife"],place.ordered_places_by_year(2010))
    assert_equal(nil,place.ordered_places_by_year(2009))
  end

  def test_process_count_degree_by_order
    place = Counter.new
    assert_equal(26, place.count_year_by_person('10101010'))
    assert_equal(21, place.count_year_by_person('10101010', 'mestrado'))
    assert_equal(5, place.count_year_by_person('40404040'))
    assert_equal(15, place.count_year_by_person('30303030', 'especializacao'))
    assert_equal(21, place.count_year_by_person('20202020'))
  end
 
end