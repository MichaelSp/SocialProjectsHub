require 'test_helper'

class ProjectTest < ActiveSupport::TestCase

  let(:project){projects(:one)}
  let(:translation_one){project_translations(:one)}
  let(:translation_two){project_translations(:two)}
  it 'can access the translated description and name' do
    assert_equal translation_one.name, project.name_de
    assert_equal translation_one.description, project.description_de

    assert_equal translation_two.name, project.name_ar
    assert_equal translation_two.description, project.description_ar
  end

  it 'can set the translation' do
    assert_equal '', project.name_fr
    project.name_fr= 'ASD'
    project.save
    assert_equal({}, project.errors.messages)
    assert_equal 'ASD', project.reload.name_fr
  end
end
