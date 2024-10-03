<p>all done!</p>
<p>score: {{score}}/{{question_count}}</p>
<table>
  % for x in missed_words:
    <tr>
      <td>{{x}}</td>
    </tr>

  % end
</table> 
<p>all done!</p>



<form action="/reset" method="post">
    <input name="selected_lesson" type="hidden"/>
    <button type="submit">reset & go home</button>
  </form>