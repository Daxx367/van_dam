require "rails_helper"

RSpec.describe ModelFileScanJob, type: :job do
  before :all do
    ActiveJob::Base.queue_adapter = :test
  end

  it "detects if file is presupported" do
    model_file = create(:model_file, filename: "file1_supported.stl")
    ModelFileScanJob.perform_now(model_file)
    model_file.reload
    expect(model_file.presupported).to eq true
  end

  it "detects if file is unsupported" do
    model_file = create(:model_file)
    ModelFileScanJob.perform_now(model_file)
    model_file.reload
    expect(model_file.presupported).to eq false
  end
end
