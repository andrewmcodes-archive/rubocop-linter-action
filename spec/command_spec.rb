# frozen_string_literal: true

require "./spec/spec_helper"

describe Command do
  subject(:command) { Command.new(config) }

  describe "#build" do
    context "when config file exists" do
      let(:config) { YAML.safe_load(config_file) }

      context "with modified scope" do
        let(:config_file) do
          <<~YAML
            check_scope: modified
          YAML
        end

        context "when base_branch configuration option is specified" do
          let(:config_file) do
            <<~YAML
              base_branch: origin/develop
              check_scope: modified
            YAML
          end

          it "uses base_branch for diff" do
            expect(command.build).to eq(
              "git diff origin/develop... --name-only --diff-filter=AM | xargs "\
              "rubocop --parallel -f json"
            )
          end
        end

        context "when base_branch is not specified" do
          it "defaults to origin/master" do
            expect(command.build).to eq(
              "git diff origin/master... --name-only --diff-filter=AM | xargs "\
              "rubocop --parallel -f json"
            )
          end
        end
      end

      context "with fail_level config" do
        let(:config_file) do
          <<~YAML
            rubocop_fail_level: error
          YAML
        end

        it "sets fail_level flag" do
          expect(command.build).to eq("rubocop --parallel -f json --fail-level error")
        end
      end

      context "with custom rubocop config file" do
        let(:config_file) do
          <<~YAML
            rubocop_config_path: .rubocop.yml
          YAML
        end

        it "sets correct flag for custom file" do
          expect(command.build).to eq("rubocop --parallel -f json -c .rubocop.yml")
        end
      end

      context "with excluded cops specified" do
        let(:config_file) do
          <<~YAML
            rubocop_excluded_cops:
              - Style/FrozenStringLiteralComment
          YAML
        end

        it "excludes specified cops" do
          expect(command.build).to eq("rubocop --parallel -f json --except Style/FrozenStringLiteralComment")
        end
      end

      context "with force_exclusion config" do
        let(:config_file) do
          <<~YAML
            rubocop_force_exclusion: true
          YAML
        end

        it "sets force-exclusion flag" do
          expect(command.build).to eq("rubocop --parallel -f json --force-exclusion")
        end
      end

      context "with all options specified" do
        let(:config_file) { File.read("./spec/fixtures/config.yml") }

        it "returns built command" do
          expect(command.build).to eq(
            "git diff origin/develop... --name-only --diff-filter=AM | xargs "\
            "rubocop --parallel -f json "\
            "--fail-level error -c .rubocop.yml --except Style/FrozenStringLiteralComment --force-exclusion"
          )
        end
      end
    end
  end

  context "when config file does not exist" do
    let(:config) { nil }

    it "returns base command" do
      expect(command.build).to eq("rubocop --parallel -f json")
    end
  end
end
