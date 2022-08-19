#Extract significant genes and transcripts from DESeqDataSet object

getSignificantGenes = function(dds.de, contrast) {
  
  dds.normalized = counts(dds.de, normalized = T)

  # get results for normalized genes
  padj.cutoff = 0.05
  
  dds.results = results(dds.de, contrast = list(contrast))
  
  # get significant results in ascending order of padj
  dds.results_significant = dds.results %>% data.frame() %>% 
    mutate(symbol = mcols(dds.de)$symbol) %>% drop_na() %>% 
    filter(padj < padj.cutoff) %>% arrange(padj)


  results = list()
  
  results$significant_genes = dds.results_significant
  
  # also get counts rearranged in order of significance
  
  significant_genes.counts = dds.normalized[match(row.names(dds.results_significant),
                                                            row.names(dds.normalized)),]
  
  rownames(significant_genes.counts) = dds.results_significant$symbol

  results$counts = significant_genes.counts

  return(results)
}
  
  
getSignificantTranscripts = function(dds.de, contrast) {
  
  dds.normalized = counts(dds.de, normalized = T)
  
  # get results for normalized genes
  padj.cutoff = 0.05
  
  dds.results = results(dds.de, contrast = list(contrast))
  
  # get significant results in ascending order of padj
  dds.results_significant = dds.results %>% data.frame() %>% 
    mutate(gene_id = mcols(dds.de)$gene_id) %>% drop_na() %>% 
    filter(padj < padj.cutoff) %>% arrange(padj)
  
  
  results = list()
  
  results$significant_genes = dds.results_significant
  
  # also get counts rearranged in order of significance
  
  significant_genes.counts = dds.normalized[match(row.names(dds.results_significant),
                                                  row.names(dds.normalized)),]
  
  rownames(significant_genes.counts) = dds.results_significant$symbol
  
  results$counts = significant_genes.counts
  
  return(results)
}
