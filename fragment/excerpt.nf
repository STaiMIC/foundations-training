#!/usr/bin/env nextflow
/*
 * Fragment excerpted from STaiMIC/sarek-wes-training, Lesson 1
 * (course/01_samplesheet.nf) — Session 2 of this training series.
 *
 * Original purpose: teach the CSV samplesheet format Sarek expects.
 * Purpose here: identify which layer (Biology / Workflow / Execution /
 * Evidence) each line belongs to. Discuss in class before running anything.
 */

nextflow.enable.dsl = 2

params.input = "${projectDir}/data/samplesheet.csv"

workflow {
    // Load and parse the CSV
    ch_samples = channel
        .fromPath(params.input, checkIfExists: true)
        .splitCsv(header: true)
        .map { row ->
            def meta = [
                patient: row.patient,
                sex    : row.sex,
                status : row.status ?: '0',
                sample : row.sample,
                lane   : row.lane
            ]
            [
                meta,
                file(row.fastq_1, checkIfExists: false),
                file(row.fastq_2, checkIfExists: false)
            ]
        }

    // Display samples
    ch_samples.view { meta, r1, r2 ->
        "✓ [${meta.patient} | sex=${meta.sex} | status=${meta.status} | sample=${meta.sample} | ${r1.name}]"
    }

    // Summary
    ch_samples
        .collect()
        .view { samples ->
            "Total samples: ${samples.size()}"
        }
}

/*
 * ---------------------------------------------------------------------
 * Fragment 2 — excerpted from nf-core/sarek's actual BWA_MEM module
 * (modules/nf-core/bwa/mem/main.nf), used by the pipeline you ran in
 * Session 2. Trimmed for readability — original has additional stub
 * and edge-case handling omitted here.
 *
 * This is a COMPLETE process — unlike Fragment 1, it has script, inputs,
 * outputs, and container/conda declarations. Identify each layer.
 * ---------------------------------------------------------------------
 */

process BWA_MEM {
    tag "$meta.id"
    label 'process_high'

    container "community.wave.seqera.io/library/bwa_htslib_samtools:83b50ff84ead50d0"

    input:
    tuple val(meta) , path(reads)
    tuple val(meta2), path(index)
    tuple val(meta3), path(fasta)
    val   sort_bam

    output:
    tuple val(meta), path("*.bam"), optional: true
    tuple val(meta), path("*.cram"), optional: true
    tuple val("${task.process}"), val('bwa'), eval('bwa 2>&1 | sed -n "s/^Version: //p"'), topic: versions

    script:
    def prefix = task.ext.prefix ?: "${meta.id}"
    def samtools_command = sort_bam ? 'sort' : 'view'
    """
    INDEX=`find -L ./ -name "*.amb" | sed 's/\\.amb\$//'`
    bwa mem \\
        -t $task.cpus \\
        \$INDEX \\
        $reads \\
        | samtools $samtools_command --threads $task.cpus -o ${prefix}.bam -
    """
}