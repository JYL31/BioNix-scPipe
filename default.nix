# This example uses the pipelines specified in the call.nix file on the
# synthetic data in this directory.
{ bionix ? import <bionix> { } }:

with bionix; let
  R = pkgs.rWrapper.override {packages = with pkgs.rPackages; [scPipe];};
in
  stage {
    name = "fastq-reformat";

    input1 = fetchFastQGZ {
        url = "https://github.com/JYL31/BioNix-scPipe/blob/901477e71031add2e4339f443f2ec30246acfceb/Sample_Data/simu_R1.fastq.gz";
        sha256 = "15q1pkwhq2yydl7dmh96jifmwd67bvmdk75xfkjyly1xkibiijwd";
    };

    input2 = fetchFastQGZ {
        url = "https://github.com/JYL31/BioNix-scPipe/blob/901477e71031add2e4339f443f2ec30246acfceb/Sample_Data/simu_R2.fastq.gz";
        sha256 = "0d6656931q8n9ml8vw980x3yh20dkzrih5fm8nvhlzkv276vm2gh";
    };

    buildInputs = [R];

    buildCommand = ''
      mkdir result
      Rscript ${./script.r}
    '';
  }
  