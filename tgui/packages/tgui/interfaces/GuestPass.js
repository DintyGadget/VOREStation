/* eslint react/no-danger: "off" */
import { sortBy } from 'common/collections';
import { useBackend } from "../backend";
import { Box, Button, LabeledList, Section } from "../components";
import { Window } from "../layouts";

export const GuestPass = (props, context) => {
  const { act, data } = useBackend(context);

  const {
    access,
    area,
    giver,
    giveName,
    reason,
    duration,
    mode,
    log,
    uid,
  } = data;

  return (
    <Window width={500} height={520} resizable>
      <Window.Content scrollable>
        {mode === 1 && (
          <Section title="Журнал активности" buttons={
            <Button
              icon="scroll"
              content="Журнал активности"
              selected
              onClick={() => act("mode", { mode: 0 })} />
          }>
            <Button
              icon="print"
              content="Печать"
              onClick={() => act("print")}
              fluid
              mb={1} />
            <Section level={2} title="Logs">
              {/* These are internally generated only. */}
              {log.length
                && log.map(l => <div key={l} dangerouslySetInnerHTML={{ __html: l }} />)
                || <Box>Пусто.</Box>}
            </Section>
          </Section>
        ) || (
          <Section title={"Гостевой терминал #" + uid} buttons={
            <Button
              icon="scroll"
              content="Журнал активности"
              onClick={() => act("mode", { mode: 1 })} />
          }>
            <LabeledList>
              <LabeledList.Item label="Issuing ID">
                <Button
                  content={giver || "Вставьте ID"}
                  onClick={() => act("id")} />
              </LabeledList.Item>
              <LabeledList.Item label="Выдано">
                <Button
                  content={giveName}
                  onClick={() => act("giv_name")} />
              </LabeledList.Item>
              <LabeledList.Item label="Причина">
                <Button
                  content={reason}
                  onClick={() => act("reason")} />
              </LabeledList.Item>
              <LabeledList.Item label="Срок (минуты)">
                <Button
                  content={duration}
                  onClick={() => act("duration")} />
              </LabeledList.Item>
            </LabeledList>
            <Button.Confirm
              icon="check"
              fluid
              content="Выдать Пропуск"
              onClick={() => act("issue")} />
            <Section title="Access" level={2}>
              {sortBy(a => a.area_name)(area).map(a => (
                <Button.Checkbox
                  checked={a.on}
                  content={a.area_name}
                  key={a.area}
                  onClick={() => act("access", { access: a.area })} />
              ))}
            </Section>
          </Section>
        )}
      </Window.Content>
    </Window>
  );
};