import { round } from 'common/math';
import { Fragment } from 'inferno';
import { useBackend } from "../backend";
import { Box, Button, Flex, Icon, LabeledList, ProgressBar, Section } from "../components";
import { Window } from "../layouts";

export const DNAForensics = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    scan_progress,
    scanning,
    bloodsamp,
    bloodsamp_desc,
  } = data;
  return (
    <Window width={540} height={326}>
      <Window.Content>
        <Section title="Состояние" buttons={
          <Fragment>
            <Button
              selected={scanning}
              disabled={!bloodsamp}
              icon="power-off"
              onClick={() => act("scanItem")}>
              {scanning ? "Остановить" : "Начать"}
            </Button>
            <Button
              disabled={!bloodsamp}
              icon="eject"
              onClick={() => act("ejectItem")}>
              Извлечь образец крови
            </Button>
          </Fragment>
        }>
          <LabeledList>
            <LabeledList.Item label="Прогресс">
              <ProgressBar
                ranges={{
                  good: [99, Infinity],
                  violet: [-Infinity, 99],
                }}
                value={scan_progress}
                maxValue={100} />
            </LabeledList.Item>
          </LabeledList>
        </Section>
        <Section title="Образец крови">
          {bloodsamp && (
            <Box>
              {bloodsamp}
              <Box color="label">
                {bloodsamp_desc}
              </Box>
            </Box>
          ) || (
            <Box color="bad">
              Образец крови не вставлен.
            </Box>
          )}
        </Section>
      </Window.Content>
    </Window>
  );
};