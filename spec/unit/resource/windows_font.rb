#
# Copyright:: Copyright 2018, Chef Software, Inc.
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require "spec_helper"

describe Chef::Resource::WindowsFont do
  let(:resource) { Chef::Resource::WindowsFont.new("some_font") }

  it "sets resource name as :windows_font" do
    expect(resource.resource_name).to eql(:windows_font)
  end

  it "sets the font_name as its name" do
    expect(resource.font_name).to eql("some_path")
  end

  it "sets the default action as :install" do
    expect(resource.action).to eql([:install])
  end

  it "supports :install action" do
    expect { resource.action :install }.not_to raise_error
    expect { resource.action :remove }.to raise_error(ArgumentError)
  end
end
