<TeXmacs|2.1>

<style|source>

<\body>
  <\active*>
    <\src-title>
      <src-style-file|notes|1.0>

      <\src-purpose>
        The style for personal notes.
      </src-purpose>

      <\src-copyright|2021>
        Zhengfei Hu
      </src-copyright>

      <\src-license>
        This software falls under the <hlink|GNU general public license,
        version 3 or later|$TEXMACS_PATH/LICENSE>. It comes WITHOUT ANY
        WARRANTY WHATSOEVER. You should have received a copy of the license
        which the software. If not, see <hlink|http://www.gnu.org/licenses/gpl-3.0.html|http://www.gnu.org/licenses/gpl-3.0.html>.
      </src-license>
    </src-title>
  </active*>

  <use-package|std|env|title-generic|header-article|section-article>

  <use-package|preview-ref|number-long-article>

  <use-package|framed-theorems>

  <use-package|qtm>

  <assign|info-flag|detailed>

  <assign|page-medium|automatic>

  use-package comment

  \;

  <assign|general-cmt|<macro|name|body|<compound|render-todo|dark blue|pastel
  blue|<arg|name>: <arg|body>>>>

  <assign|cmt|<macro|body|<general-cmt|huzf|<arg|body>>>>
</body>

<\initial>
  <\collection>
    <associate|page-medium|screen>
    <associate|preamble|true>
  </collection>
</initial>