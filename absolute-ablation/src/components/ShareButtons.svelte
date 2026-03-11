<script lang="ts">
  interface Props {
    title: string;
    url?: string;
  }

  let { title, url = '' }: Props = $props();

  let copied = $state(false);
  let showTooltip = $state(false);

  function getShareUrl() {
    return url || (typeof window !== 'undefined' ? window.location.href : '');
  }

  function shareTwitter() {
    const shareUrl = getShareUrl();
    window.open(
      `https://x.com/intent/tweet?text=${encodeURIComponent(title)}&url=${encodeURIComponent(shareUrl)}`,
      '_blank',
      'width=550,height=420'
    );
  }

  function shareLinkedIn() {
    const shareUrl = getShareUrl();
    window.open(
      `https://www.linkedin.com/sharing/share-offsite/?url=${encodeURIComponent(shareUrl)}`,
      '_blank',
      'width=550,height=420'
    );
  }

  function shareHackerNews() {
    const shareUrl = getShareUrl();
    window.open(
      `https://news.ycombinator.com/submitlink?u=${encodeURIComponent(shareUrl)}&t=${encodeURIComponent(title)}`,
      '_blank'
    );
  }

  async function copyLink() {
    const shareUrl = getShareUrl();
    try {
      await navigator.clipboard.writeText(shareUrl);
      copied = true;
      setTimeout(() => { copied = false; }, 2000);
    } catch {
      // fallback
    }
  }
</script>

<div
  class="share-container"
  onmouseenter={() => showTooltip = true}
  onmouseleave={() => showTooltip = false}
  role="group"
  aria-label="Share options"
>
  <span class="share-label">Share</span>
  <div class="share-buttons">
    <button onclick={shareTwitter} class="share-btn" title="Share on X/Twitter" aria-label="Share on X/Twitter">
      <svg viewBox="0 0 24 24" class="w-4 h-4" fill="currentColor">
        <path d="M18.244 2.25h3.308l-7.227 8.26 8.502 11.24H16.17l-5.214-6.817L4.99 21.75H1.68l7.73-8.835L1.254 2.25H8.08l4.713 6.231zm-1.161 17.52h1.833L7.084 4.126H5.117z"/>
      </svg>
    </button>
    <button onclick={shareLinkedIn} class="share-btn" title="Share on LinkedIn" aria-label="Share on LinkedIn">
      <svg viewBox="0 0 24 24" class="w-4 h-4" fill="currentColor">
        <path d="M20.447 20.452h-3.554v-5.569c0-1.328-.027-3.037-1.852-3.037-1.853 0-2.136 1.445-2.136 2.939v5.667H9.351V9h3.414v1.561h.046c.477-.9 1.637-1.85 3.37-1.85 3.601 0 4.267 2.37 4.267 5.455v6.286zM5.337 7.433c-1.144 0-2.063-.926-2.063-2.065 0-1.138.92-2.063 2.063-2.063 1.14 0 2.064.925 2.064 2.063 0 1.139-.925 2.065-2.064 2.065zm1.782 13.019H3.555V9h3.564v11.452zM22.225 0H1.771C.792 0 0 .774 0 1.729v20.542C0 23.227.792 24 1.771 24h20.451C23.2 24 24 23.227 24 22.271V1.729C24 .774 23.2 0 22.222 0h.003z"/>
      </svg>
    </button>
    <button onclick={shareHackerNews} class="share-btn hn" title="Share on Hacker News" aria-label="Share on Hacker News">
      <svg viewBox="0 0 24 24" class="w-4 h-4" fill="currentColor">
        <path d="M0 0v24h24V0H0zm12.8 14.4v5.2h-1.6v-5.2L7 4.8h1.8l3.2 6.2 3.2-6.2H17l-4.2 9.6z"/>
      </svg>
    </button>
    <button onclick={copyLink} class="share-btn copy" title="Copy link" aria-label="Copy link">
      {#if copied}
        <svg viewBox="0 0 24 24" class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="2">
          <path stroke-linecap="round" stroke-linejoin="round" d="M5 13l4 4L19 7"/>
        </svg>
      {:else}
        <svg viewBox="0 0 24 24" class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="2">
          <path stroke-linecap="round" stroke-linejoin="round" d="M13.828 10.172a4 4 0 00-5.656 0l-4 4a4 4 0 105.656 5.656l1.102-1.101m-.758-4.899a4 4 0 005.656 0l4-4a4 4 0 00-5.656-5.656l-1.1 1.1"/>
        </svg>
      {/if}
    </button>
  </div>
  {#if copied}
    <span class="copied-toast">Link copied!</span>
  {/if}
</div>

<style>
  .share-container {
    display: flex;
    align-items: center;
    gap: 0.75rem;
    position: relative;
  }
  .share-label {
    font-size: 0.75rem;
    font-weight: 600;
    text-transform: uppercase;
    letter-spacing: 0.05em;
    color: #9ca3af;
  }
  .share-buttons {
    display: flex;
    gap: 0.25rem;
  }
  .share-btn {
    display: flex;
    align-items: center;
    justify-content: center;
    width: 2.25rem;
    height: 2.25rem;
    border-radius: 8px;
    border: 1px solid #e5e7eb;
    background: white;
    color: #6b7280;
    cursor: pointer;
    transition: all 0.2s ease;
  }
  .share-btn:hover {
    background: #f3f4f6;
    color: #111827;
    transform: translateY(-1px);
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
  }
  .share-btn.copy.copied {
    color: #16a34a;
    border-color: #86efac;
    background: #f0fdf4;
  }
  .copied-toast {
    position: absolute;
    right: 0;
    top: -2rem;
    background: #111827;
    color: white;
    padding: 0.25rem 0.75rem;
    border-radius: 6px;
    font-size: 0.7rem;
    font-weight: 500;
    white-space: nowrap;
    animation: fadeInUp 0.2s ease;
  }
  @keyframes fadeInUp {
    from {
      opacity: 0;
      transform: translateY(4px);
    }
    to {
      opacity: 1;
      transform: translateY(0);
    }
  }
</style>
