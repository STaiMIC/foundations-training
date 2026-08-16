#!/usr/bin/env nextflow
nextflow.enable.dsl=2

/*
 * Session 5 — Minimal two-process DSL2 workflow
 * Purpose: trace biological input -> channel -> process -> output -> test
 * Samplesheet mirrors real nf-core/ampliseq structure (sampleID, forwardReads, 
 * reverseReads) from Session 2 — reads themselves are illustrative only, this 
 * workflow does not perform real alignment.
 */

params.input = "${projectDir}/data/microbiome_samplesheet.csv"

process READ_SAMPLE {
    input:
    tuple val(sampleID), val(forwardReads), val(reverseReads)

    output:
    tuple val(sampleID), path("${sampleID}.txt")

    script:
    """
    echo "Sample: ${sampleID}" > ${sampleID}.txt
    echo "Forward reads: ${forwardReads}" >> ${sampleID}.txt
    echo "Reverse reads: ${reverseReads}" >> ${sampleID}.txt
    """
}

process COUNT_CHARACTERS {
    publishDir "results", mode: 'copy'

    input:
    tuple val(sampleID), path(sample_file)

    output:
    path "${sampleID}.count.txt"

    script:
    """
    wc -c < ${sample_file} > ${sampleID}.count.txt
    """
}

workflow {
    sample_ch = Channel
        .fromPath(params.input)
        .splitCsv(header: true)
        .map { row -> tuple(row.sampleID, row.forwardReads, row.reverseReads) }

    READ_SAMPLE(sample_ch)
    COUNT_CHARACTERS(READ_SAMPLE.out)
}