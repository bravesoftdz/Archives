$(function () {
    $("#set_period").change(function (event) {
        var beginDate = $("#begin_date").val();
        var endDate = $("#end_date").val();
        location.href = "budget?begin=" + beginDate + "&end=" + endDate + "&period=" + $(this).children("option:selected").val();
    });

    $(".editble-icon").click(function (event) {

        var editField = $("#text-edit-field").html();
        var editText = $(this).siblings(".editble-field").text();
        $(this).closest(".editble-text").append(editField);
        $(this).siblings(".editble_text_edit").children("input").val(editText);

        $(".apply-icon").click(function (event) {
            var data = {
                "title": $(this).siblings(".editble_text_edit").children("input").val()
                , "id": $(this).closest(".editble-text").attr("id")
            };
            $.post("/article/update", data);
        });

        $(this).siblings(".editble-field").remove();
        $(this).remove();
    });
});
