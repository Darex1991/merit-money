require 'spec_helper'

describe Kudo do
  it { should have_db_column(:value).of_type(:integer) }
  it { should have_db_column(:comment).of_type(:text) }

  it { should delegate_method(:giver).to(:weekly_kudo) }

  it { should belong_to(:receiver).class_name("User") }
  it { should belong_to(:weekly_kudo).class_name("WeeklyKudo") }

  it { should ensure_inclusion_of(:value).in_range(1..20).
                  with_message("you are not allowed to go beyond kudos limit") }
  it { should validate_presence_of(:value) }
  it { should validate_presence_of(:receiver_id) }
  it { should validate_presence_of(:weekly_kudo_id) }
  it { should allow_value(nil, "").for(:comment) }

  context "custom validation" do
    subject(:kudo) { build(:kudo) }

    it { should be_valid }

    context "setting receiver as same as giver" do
      before(:each) do
        kudo.receiver = kudo.giver
        kudo.valid?
      end

      it { should_not be_valid }
      it { should have(1).errors }
    end
  end

  context "giving and receiving kudo" do
    context "green field" do
      let!(:tom) { create(:user, email: 'tom@selleo.com', name: 'Tom') }
      let!(:bart) { create(:user, email: 'bart@selleo.com', name: 'Bart') }

      before do
        Timecop.freeze(Time.parse('2013-02-27 13:15 UTC'))
      end

      after do
        Timecop.return
      end

      context "giving kudo" do

        let!(:kudo) { tom.thanks(bart, {value: 3, comment: 'for sending feedback to the team'}) }

        it { expect(Kudo.count).to eq(1) }
        it { expect(kudo).to eq(tom.kudos.first) }
        it { expect(kudo.value).to eq(3) }
        it { expect(kudo.comment).to_not be_blank }

        context "giver" do
          it { expect(tom).to have(1).kudos }
          it { expect(tom).to have(0).kudos_received }

          let(:weekly_kudo) { kudo.weekly_kudo }
          it { expect(weekly_kudo.kudos_left).to eq(17) }

          let(:week) { weekly_kudo.week }
          it { expect(week).to eq(Week.current) }
        end

        context "receiver" do
          it { expect(bart).to have(0).kudos }
          it { expect(bart).to have(1).kudos_received }
        end
      end

      context "giving more then you have is not allowed" do
        let!(:kudo) { tom.thanks(bart, {value: 15, comment: 'for sending feedback to the team'}) }

        it { expect { tom.thanks(bart, {value: 6}) }.to_not change { Kudo.count } }
      end

    end

    pending "will be done in milestone: BackEnd-2#sks-34" do
      context "in last week each user have their weekly kudo" do
        # it will calculate stats from last week
      end
    end

    pending "will be done in milestone: BackEnd-3#sks-35" do
      context "there is two weeks gap between current week and last week that user have weekly kudo" do
        # it should recreate all missing weekly kudos up to current week
      end
    end

  end
end
