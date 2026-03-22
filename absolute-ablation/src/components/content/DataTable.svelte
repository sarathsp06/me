<script lang="ts">
  interface Props {
    headers: string[];
    rows: (string | number)[][];
    highlightRow?: number;
  }

  let { headers, rows, highlightRow }: Props = $props();
</script>

<div class="table-wrapper">
  <table class="data-table">
    <thead>
      <tr>
        {#each headers as header}
          <th>{header}</th>
        {/each}
      </tr>
    </thead>
    <tbody>
      {#each rows as row, i}
        <tr class:highlight={highlightRow === i}>
          {#each row as cell, j}
            <td class:bold-cell={highlightRow === i && j === row.length - 1}>
              {cell}
            </td>
          {/each}
        </tr>
      {/each}
    </tbody>
  </table>
</div>

<style>
  .table-wrapper {
    overflow-x: auto;
    margin: 1.5rem 0;
    border-radius: 0.75rem;
    border: 1px solid #e5e7eb;
  }

  .data-table {
    width: 100%;
    border-collapse: separate;
    border-spacing: 0;
    font-size: 0.9rem;
  }

  .data-table thead tr {
    background: linear-gradient(135deg, #1e293b, #334155);
  }

  .data-table th {
    padding: 0.85rem 1rem;
    text-align: left;
    font-weight: 600;
    font-size: 0.8rem;
    text-transform: uppercase;
    letter-spacing: 0.05em;
    color: #cbd5e1;
    white-space: nowrap;
  }

  .data-table td {
    padding: 0.75rem 1rem;
    border-top: 1px solid #f1f5f9;
    color: #334155;
    white-space: nowrap;
  }

  .data-table tbody tr {
    transition: background-color 0.15s ease;
  }

  .data-table tbody tr:hover {
    background-color: #f8fafc;
  }

  .data-table tbody tr.highlight {
    background-color: #eff6ff;
    color: #1e3a5f;
  }

  .data-table tbody tr.highlight td {
    color: #1e3a5f;
  }

  .bold-cell {
    font-weight: 700;
  }
</style>
