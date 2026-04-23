<script lang="ts">
  interface Props {
    headers: string[];
    rows: (string | number)[][];
    highlightRow?: number;
  }

  let { headers, rows, highlightRow }: Props = $props();
</script>

<div class="overflow-x-auto my-6 rounded-xl border border-gray-200">
  <table class="w-full border-separate border-spacing-0 text-[0.9rem]">
    <thead>
      <tr class="bg-gradient-to-br from-slate-800 to-slate-700">
        {#each headers as header}
          <th class="py-3.5 px-4 text-left font-semibold text-[0.8rem] uppercase tracking-wide text-slate-300 whitespace-nowrap">{header}</th>
        {/each}
      </tr>
    </thead>
    <tbody>
      {#each rows as row, i}
        <tr class="transition-colors duration-150 hover:bg-white" class:bg-blue-50={highlightRow === i} class:text-[#1e3a5f]={highlightRow === i}>
          {#each row as cell, j}
            <td class="py-3 px-4 border-t border-slate-100 whitespace-nowrap" class:text-[#1e3a5f]={highlightRow === i} class:text-slate-700={highlightRow !== i} class:font-bold={highlightRow === i && j === row.length - 1}>
              {cell}
            </td>
          {/each}
        </tr>
      {/each}
    </tbody>
  </table>
</div>
