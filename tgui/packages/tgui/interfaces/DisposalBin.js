import { useBackend } from "../backend";
import { Button, LabeledList, Section, Box, ProgressBar } from "../components";
import { Window } from "../layouts";

export const DisposalBin = (props, context) => {
  const { act, data } = useBackend(context);
  let stateColor;
  let stateText;
  if (data.mode === 2) {
    stateColor = "good";
    stateText = "Готово";
  } else if (data.mode <= 0) {
    stateColor = "bad";
    stateText = "Н/Д";
  } else if (data.mode === 1) {
    stateColor = "average";
    stateText = "Подготовка";
  } else {
    stateColor = "average";
    stateText = "Бездействие";
  }
  return (
    <Window
      width={300}
      height={250}>
      <Window.Content>
        <Section>
          <Box bold m={1}>
            Статус
          </Box>
          <LabeledList>
            <LabeledList.Item label="Состояние" color={stateColor}>
              {stateText}
            </LabeledList.Item>
            <LabeledList.Item
              label="Давление">
              <ProgressBar
                ranges={{
                  bad: [-Infinity, 0],
                  average: [0, 99],
                  good: [99, Infinity],
                }}
                value={data.pressure}
                minValue={0}
                maxValue={100} />
            </LabeledList.Item>
          </LabeledList>
          <Box bold m={1}>
            Управление
          </Box>
          <LabeledList>
            <LabeledList.Item label="Рычаг">
              <Button
                icon="toggle-off"
                disabled={data.isAI || data.panel_open}
                content="Поднят"
                selected={data.flushing ? null : "selected"}
                onClick={() => act("disengageHandle")}
              />
              <Button
                icon="toggle-on"
                disabled={data.isAI || data.panel_open}
                content="Опущен"
                selected={data.flushing ? "selected" : null}
                onClick={() => act("engageHandle")}
              />
            </LabeledList.Item>
            <LabeledList.Item label="Питание">
              <Button
                icon="toggle-off"
                disabled={data.mode === -1}
                content="Выкл"
                selected={data.mode ? null : "selected"}
                onClick={() => act("pumpOff")}
              />
              <Button
                icon="toggle-on"
                disabled={data.mode === -1}
                content="Вкл"
                selected={data.mode ? "selected" : null}
                onClick={() => act("pumpOn")}
              />
            </LabeledList.Item>
            <LabeledList.Item label="Извлечь">
              <Button
                icon="sign-out-alt"
                disabled={data.isAI}
                content="Извлечь содержимое"
                onClick={() => act("eject")}
              />
            </LabeledList.Item>
          </LabeledList>
        </Section>
      </Window.Content>
    </Window>
  );
};
