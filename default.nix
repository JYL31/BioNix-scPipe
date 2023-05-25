# This example uses the pipelines specified in the call.nix file on the
# synthetic data in this directory.
{ bionix ? import <bionix> { } }:

with bionix; let
  R = pkgs.rWrapper.override {packages = with pkgs.rPackages; [scPipe];};
in
  stage {
    name = "fastq-reformat";

    input1 = fetchFastQGZ {
        url = "https://raw.githubusercontent.com/JYL31/BioNix-scPipe/main/Sample_Data/simu_R1.fastq.gz";
        sha256 = "1zc5hqjf0ydh5vv2mc34la3rz5ym77zniriy4dfrkfw8w370wn4g";
    };

    input2 = fetchFastQGZ {
        url = "https://raw.githubusercontent.com/JYL31/BioNix-scPipe/main/Sample_Data/simu_R2.fastq.gz";
        sha256 = "035ch20l0vd3f5637yi0s3hvb0zacdhvcrks9abwmqqzvbbb46xm";
    };

    buildInputs = [R];

    buildCommand = ''
      Rscript ${./script.r}
    '';
  }
  