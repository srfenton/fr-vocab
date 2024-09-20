<table>
  % for x in vocab_dict:
    <tr>
      <td>{{x}}</td>
      <td>
        <form action="/select" method="post">
        <input name="selected_lesson" type="hidden" value="{{x}}"/>
        <button type="submit">{{x}}</button>
      </form>
      </td>
    </tr>

  % end
</table>